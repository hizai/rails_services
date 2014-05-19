class RakeTask
  def initialize task, options = {}
    @task = task

    options = options.reverse_merge :rails_env => Rails.env
    @args   = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
  end

  def run
    system "rake #{@task} #{@args.join(' ')} --trace 2>&1 >> #{Rails.root}/log/rake.log &"
  end
end