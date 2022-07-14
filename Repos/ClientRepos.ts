import Repos from "./Repos";
import Client from "../models/Client";
class ClientRepos {
    async addClient(client: Client) {

        return Repos.add(`http://localhost:5245/api/v1/client`, client);
    }

    async getClientsByPartnerId() {
        return Repos.get(`http://localhost:5245/api/v1/client`);
    }

    async deleteClientById(id: number) {
        return Repos.delete(`http://localhost:5245/api/v1/client?id=${id}`);
    }

    async editClientById(client: Client) {
        return Repos.put(`http://localhost:5245/api/v1/client`, client)
    }

    async searchClientByUsername(clientname :string){
        return Repos.get(`http://localhost:5245/api/v1/clients/${clientname}/clientsearch`)
    }
}

export default new ClientRepos()