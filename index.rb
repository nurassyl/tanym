# Глобальная переменная
$global_name = 'Nurassyl'

# Функция с дефолтным значением
def get_name(name = nil)
  name || $global_name
end

# setTimeout аналог
Thread.new do
  sleep 5
  puts get_name
end

# setInterval аналог
Thread.new do
  loop do
    sleep 1
    puts get_name('Guldana')
  end
end

# Чтобы главный поток не завершился сразу
sleep

