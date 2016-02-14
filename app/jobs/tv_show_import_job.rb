require 'to_name'

class TvShowImportJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    Dir.chdir tv_show_dir
    Dir.glob(acceptable_file_types).each do |path|
      import_episode(path, user)
    end
  end

  private

  def tv_show_dir
    dir = Rails.application.secrets[:tv_show_dir]
    if dir.starts_with? '~'
      Dir.home + dir.tr('~', '')
    else
      dir
    end
  end

  def import_episode(path, user)
    episode = path.split(File::SEPARATOR).last
    info = ToName.to_name episode

    tv_show = TvShow.find_or_create_by(name: info.name,
                                       year: info.year, user: user)

    Episode.create(tv_show: tv_show, season: info.series,
                   number: info.episode, user: user)
  end

  def acceptable_file_types
    ['**/*.mkv', '**/*.avi', '**/*.mp4', '**/*.mov']
  end
end
