interface Users {
  id?: number,
  username: string,
  email: string,
  password: string,
  time_of_login?: Date,
  display_name: string,
  partner_id?: number
}
export default Users;