namespace :tv_show do
  desc 'Generate dummy files for import'
  task :generate_shows, [:path] => :environment do |_, args|
    path = Dir.home + args[:path]
    dir_exists(path) || next

    game_of_thrones = {
      name: 'Game Of Thrones',
      seasons: [10, 10, 10, 10, 10, 10]
    }

    its_always_sunny = {
      name: "It's Always Sunny In Philadelphia",
      seasons: [7, 10, 15, 13, 12, 14, 13, 10, 10, 10, 10]
    }

    create_show game_of_thrones, path
    create_show its_always_sunny, path
  end

  private

  def create_dir(path)
    Dir.mkdir(path) unless Dir.exist?(path)
  end

  def create_show(show, path)
    create_dir path + "/#{show[:name]}"
    path += "/#{show[:name]}"
    show[:seasons].count.times do |season|
      create_season show, season, show[:seasons][season], path
    end
  end

  def create_season(show, season, episode_count, path)
    create_dir path + "/Season #{season + 1}"
    path += "/Season #{season + 1}"
    episode_count.times do |episode|
      create_episode show, season, episode, path
    end
  end

  def create_episode(show, season, episode, path)
    File.open(path + "/#{show[:name]}.S#{season + 1}.E#{episode + 1}.mkv", 'w')
  end

  def dir_exists(path)
    unless Dir.exist?(path)
      puts 'This directory does not exist'
      false
    end
    true
  end
end
