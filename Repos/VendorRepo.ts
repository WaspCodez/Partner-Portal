import Repos from "./Repos";

class VendorRepo {
    async getVendorDetails(id: number) {
        return Repos.get(`http://localhost:5245/api/v1/clients/${id}/vendors`);
    }
}

export default new VendorRepo();
