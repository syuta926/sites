



require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

get '/' do
  erb :index
end

get '/result' do
  stress_frequency = params[:stress_frequency]
  stress_hours = params[:stress_hours].to_i
  stress_date = params[:stress_date]
  stress_symptoms = params[:stress_symptoms]
  stress_cause = params[:stress_cause]
  stress_relief = params[:stress_relief]
  eat = params[:eat]
  
  if stress_frequency == 'なし'
    base_level = 1
  elsif stress_frequency == 'たまに'
    base_level = 2
  elsif stress_frequency == 'ほとんど'
    base_level = 3
  elsif stress_frequency == '毎日'
    base_level = 4
  end
  
  if eat == 'なし'
    eat_level = 1
  elsif eat == 'しばしば'
    eat_level = 2
  elsif eat == 'ほとんど'
    eat_level = 3
  elsif eat == '毎日'
    eat_level = 4
  end

  stress_level = base_level + eat_level + stress_hours * 2 + stress_symptoms.size / 3 
  
  if stress_level <= 6
    explanation = "不健康です！顔がげっそりしてるかも！改善しよう！\n"
  elsif stress_level <= 10
    explanation = "健康です！このままの生活の維持できるよう努めましょう！ \n"
  else
    explanation = "超健康です！このまま理想の生活を維持しましょう！ \n"
  end
  
  @stress_explanation = explanation.gsub("\n", "<br>")

  erb :result
end

