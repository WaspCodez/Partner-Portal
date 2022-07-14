using System.Collections;

namespace login_user.LoginDetails
{
    public class loginuserAPI
    {
        private readonly loginuserRepo _loginuserRepo;
        public bool hasError = false;
        public String lastErrorMessage = "";
        public loginuserAPI()
        {
            _loginuserRepo = new loginuserRepo();

        }

        public async Task<IEnumerable<loginUser>> loginUsergGetAsync()
        {
            try
            {
                var loginUserList = await _loginuserRepo.loginUserGetAsync();
                return loginUserList;
            }
            catch (Exception ex)
            {
                hasError= true;
                lastErrorMessage = ex.Message;
                return Enumerable.Empty<loginUser>();
               
            }
        }

    }
}
