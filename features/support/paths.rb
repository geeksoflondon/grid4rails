# features/support/paths.rb

def path_to(page_name)
  case page_name

  when /schedule a talk/i
    schedule_talk_path
    
  when /schedule/i
    schedule_path

  when /home/i
    root_path

  # and so forth...

  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end
