using PhinityPartnerPortal;

namespace login_user.LoginDetails
{
    public class loginuserRepo
    {
        private readonly DapperAdapter _dapper;

        public loginuserRepo()
        {
            _dapper = new DapperAdapter();
        }

        public async Task<IEnumerable<loginUser>> loginUserGetAsync()
        {
            var loginUserList = await _dapper.QueryAsync<loginUser>("func_get_login_user", null);
                //QueryAsync("func_get_login_user", null);

            return loginUserList;
        }
    }
}
