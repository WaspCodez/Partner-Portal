import repos from './Repos';

class ClientRepo {

  async getClientsByPartnerId() {
    return repos.get(`http://localhost:5245/api/v1/client`);
  }

  async addClient(username: String) {
    return repos.add(`http://localhost:5245/api/v1/client?name=${username}`);
  }


}

export default new ClientRepo();
