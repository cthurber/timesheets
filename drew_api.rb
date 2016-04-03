require 'capybara/poltergeist'

# class TreeHouseAPI
$session = Capybara::Session.new(:selenium) # figure out poltergeist errors
$logged_in = false
$viewing_timesheet = false
# Capybara.default_max_wait_time = 10

def get_login_info

  raw_info = []
  File.open("./uname.txt", "r") do |f|
    f.each_line do |line|
      raw_info.push(line.delete!("\n"))
    end
  end

  login_info = Hash.new
  login_info['password'] = raw_info.pop()
  login_info['username'] = raw_info.pop()
  return login_info

end

def login(username=nil, password=nil)

  if (username == nil || password == nil)
    login_info = get_login_info()
  else
    login_info = Hash.new
    login_info['username'] = 'ding'
    login_info['password'] = 'dong'
  end

  # Go to login page
  $session.visit "https://idp.drew.edu/nidp/app/login?id=DuoProxyADFS&sid=7&option=credential&sid=7"

  # Fill out login form
  forms = $session.find_all(:css, "input[class$='smalltext']")
  forms[0].set(login_info['username'])
  forms[1].set(login_info['password'])
  $session.click_button('Login')

  $session.visit("https://treehouse.drew.edu/web/home-community/students")

end

# Go to timesheet for
def get_timesheet(job_id) # TODO remove default param
  # Only attempt if logged_in
  # if(!$logged_in)
  #   login()
  # end

  # Go to job selection page
  $session.visit("https://treehouse.drew.edu/web/home-community/students")
  $session.within(:css, "fieldset.outter") do
    $session.within(:css, "table") do
      $session.first(:css, 'a').click
    end
  end
  $session.find(:css, "input[value$='Position Selection']").click

  # Select job
  $session.within(:css, "table.dataentrytable") do
    rows = $session.find_all(:css, "tr")
    for row in rows do
      if row.has_content?(job_id)
        row.find(:css, "input[name$='Jobs']").click
      end
    end
  end

  $session.click_button("Time Sheet")
  # SET TIMESHEET LIVE TO TRUE
end

# Takes a shift hashtable
def fill_hours(shift)
  # TODO Work on integrating globals
  # if(!$viewing_timesheet)
  #   $get_timesheet()
  # end
  nums_to_days = {0 => "Monday", 1 => "Tuesday", 2 => "Wednesday", 3 => "Thursday", 4 => "Friday", 5 => "Saturday", 6 => "Sunday"}
  day = nums_to_days[shift["day"]]

  $session.within("table.bordertable") do
    $session.within("tbody") do
      header_cells = $session.find_all(:css, "td.dbheader")
      enter_hours = $session.find_all(:css, "td.dbdefault")

      i = 0
      while(!header_cells[i].text.include? day) do
        i += 1
      end
      $session.within(enter_hours[i]) do
        $session.first('a.fieldsmalltext').click
      end

      # Go to the timesheet

      # TODO Fix async from here down
      begin
        page.all('.content_item').any? { |element| element.text =~ /#{expected_title}/ }
      rescue Selenium::WebDriver::Error::ObsoleteElementError

        page.all('.content_item').any? { |element| element.text =~ /#{expected_title}/ }
      end
      $session.find(:css, "input[id$=input#timein_input_id")
      $session.find(:css, "input[id$=input#timeout_input_id").set(shift["end_time"])

    end
  end
end

# end

# Tests without class:
login()
get_timesheet('111212')

shiftA = {"day" => 3, "start_time" => "9:30", "end_time" => "11:30", "shift_num" => "1"}
shiftB = {"day" => 5, "start_time" => "8:00", "end_time" => "9:00", "shift_num" => "2"}

fill_hours(shiftA)
