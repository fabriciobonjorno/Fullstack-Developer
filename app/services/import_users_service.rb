class ImportUsersService
  require 'roo'
 
  def initialize(file)
    @file = file
  end

  def call
    import_users
  end

  private
  
  def import_users
    puts 'Importing Data'
    debugger
    data = Roo::Spreadsheet.open(@file) # open spreadsheet
    headers = data.row(1) # get header row
    data.each_with_index do |row, idx|
      next if idx == 0 # skip header row
      # create hash from headers and cells
      user_data = Hash[[headers, row].transpose]
      # next if user exists
      if User.exists?(email: user_data['email'])
        puts "User with email #{user_data['email']} already exists"
        next
      end
      
      user = User.new(user_data)
      puts "Saving User with email '#{user.email}'"
      user.save!
    end
  end
end