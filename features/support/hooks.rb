After '@javascript' do
  Capybara.send('session_pool').each do |_, session|
    next unless session.driver.is_a?(Capybara::Poltergeist::Driver)
    session.driver.restart
  end
end

Before do
  Settings.slot_configuration.increment = 30
  Settings.slot_configuration.end_time = 20
end

Before '@action_cable' do
  RedisTest.start
  RedisTest.configure(:default)
end

After '@action_cable' do
  RedisTest.clear
end

at_exit do
  RedisTest.stop
end