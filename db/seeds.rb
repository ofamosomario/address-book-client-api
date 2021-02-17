Organization.create([

  { name: 'Organization 1' },
  { name: 'Organization 2' },
  { name: 'Organization 3' },
  { name: 'Organization 4' },
  { name: 'Organization 5' },

])

User.create([

  { email: 'user1@gmail.com' , password: '123123' },
  { email: 'user2@gmail.com' , password: '123123' },

])

OrganizationUser.create([

  { user_id: 1, organization_id: 1 , admin: true }

])