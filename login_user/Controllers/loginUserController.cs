using login_user.LoginDetails;
using Microsoft.AspNetCore.Mvc;

namespace login_user.Controllers
{
   
  [ApiController]
  [Route("api/v1/loginUser")]
  public class LoginUserController : ControllerBase
  {
           
    public LoginUserController(ILogger<LoginUserController> logger)
    {
                
    }

    [HttpGet]
    public async Task<IActionResult> Get()
    {
      var api = new loginuserAPI();
      var loginUserList = await api.loginUsergGetAsync();

      return api.hasError
      ? BadRequest(api.lastErrorMessage)
      : Ok(loginUserList);
    }
  }
}
