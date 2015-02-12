namespace :cachetool do
  desc <<-DESC
    Installs cachetool.phar to the shared directory
    In order to use the .phar file, the cachetool command needs to be mapped:
      SSHKit.config.command_map[:cachetool] = "\#{shared_path.join("cachetool.phar")}"
    This is best used after deploy:starting:
      namespace :deploy do
        after :starting, 'cachetool:install_executable'
      end
  DESC
  task :install_executable do
    on release_roles(fetch(:cachetool_roles)) do
      within shared_path do
        unless test "[", "-e", "cachetool.phar", "]"
          execute :curl, "-sO", fetch(:cachetool_download_url)
        end
      end
    end
  end

  task :run, :command do |t, args|
    args.with_defaults(:command => :list)
    on release_roles(fetch(:cachetool_roles)) do
      within fetch(:cachetool_working_dir) do
        execute :cachetool, args[:command], *args.extras
      end
    end
  end

  task :reset do
    if fetch(:cachetool_lib) == :apc
      invoke "cachetool:run", "apc:cache:clear all", fetch(:cachetool_reset_flags)
    else
      invoke "cachetool:run", "opcache:reset", fetch(:cachetool_reset_flags)
    end
  end

  after 'deploy:symlink:release', 'cachetool:reset'
end

namespace :load do
  task :defaults do
    set :cachetool_reset_flags, '--fcgi'
    set :cachetool_roles, :all
    set :cachetool_lib, :opcache
    set :cachetool_working_dir, -> { fetch(:release_path) }
    set :cachetool_download_url, "http://gordalina.github.io/cachetool/downloads/cachetool.phar"
  end
end
