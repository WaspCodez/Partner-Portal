import repos from './Repos';

class LoginUserRepo{
    async getLoginUser(){
        return repos.get(`http://localhost:5245/api/v1/loginuser`);
        //return repos.get(`http://localhost:5245/api/v1/loginuser`);
    }

}

export default new LoginUserRepo();