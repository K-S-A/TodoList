user = User.create(email: 'atillas@ukr.net', password: '321321321', first_name: 'John', last_name: 'Snow')

user.projects.create([{title: 'For Home'}, {title: 'Complete the test task for Ruby Garage'}])

user.projects.first.tasks.create([
  {name: 'Open this mock-up in Adobe Fireworks'},
  {name: 'Attentively check the file'},
  {name: 'Write HTML & CSS'},
  {name: 'Add Javascript to implement adding / editing / removing for todo items and lists taking into account as more use cases as possible'}
])

# # TODO - uncomment
# user.projects.first.tasks.create([
#   {name: 'Buy a milk'},
#   {name: 'Call Mam'},
#   {name: 'Clean the room'},
#   {name: 'Repair the DVD Player'}
# ])
