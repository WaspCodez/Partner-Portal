import Repos from './Repos';
import Users from '../models/Users';


class LoginRepo{

    async login(username:string, password:string){
        return Repos.post(`http://localhost:5245/api/v1/login?username=${username}&password=${password}`);
    }

    async getLoginUser(){
        return Repos.get(`http://localhost:5245/api/v1/loginuser`);
    }

    async deleteUserByID(id:number){
        return Repos.delete(`http://localhost:5245/api/v1/loginuser?id=${id}`);
    }

    async editUserById(users : Users){
       return Repos.put(`http://localhost:5245/api/v1/loginuser`,users);
    }

    async addUser(users : Users){
        return Repos.add(`http://localhost:5245/api/v1/loginuser`,users);
    }

    async searchUser(username: string){
        return Repos.get(`http://localhost:5245/api/v1/loginuser/${username}/LoginUsersearch`)
    }
    


}

export default new LoginRepo();