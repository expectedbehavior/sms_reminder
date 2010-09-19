Bootstrapper.for :production do |b|
end

Bootstrapper.for :development do |b|
end

Bootstrapper.for :test do |b|
  b.truncate_tables :all
end

