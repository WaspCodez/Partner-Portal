<script setup lang="ts">

import { useRouter } from 'vue-router'
import { defineProps, onMounted, ref } from 'vue';
import { routeLocationKey } from 'vue-router';
import VendorRepo from '../Repos/VendorRepo';

const props = defineProps(["id"]);
const router = useRouter();

interface Vendor_User {
    id: number,
    vendor_name: string,
    category: string,
    description: string,
    email: string,
    partner_id: number,
    client_id: number

}

let VendorUser = ref<Vendor_User[]>([]);


onMounted(async () => {
    await getVendor();
})


async function getVendor() {
    VendorUser.value = await VendorRepo.getVendorDetails(props.id);
    let VendorCount = VendorUser.value.length;
    document.getElementById("numberV").innerHTML += VendorCount;

}

function goback(){
    router.push('clientRegister')
}
</script>

<template>
    <div>
        <h1 class="vendorHeader">Vendor Users</h1>

        <div class="vendordiv">
            <p class="numberofvendors"> Number of vendors </p>
            <h1 id="numberV"> </h1>

        </div>
        <div>
            <table>
                <thead>
                    <tr>
                        <th>Vendor Id</th>
                        <th>Vendor Name</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="vendordetails in VendorUser">
                        <td>{{ vendordetails.id }}</td>
                        <td>{{ vendordetails.vendor_name }}</td>
                        <td> {{ vendordetails.category }}</td>
                        <td>{{ vendordetails.description }}</td>
                        <td>{{ vendordetails.email }}</td>
                    </tr>
                </tbody>
            </table>
        </div>

       <button @click="router.push('clientRegister')" class="bn632-hover bn20">← Back</button>
    </div>
</template>

<style>
.vendorHeader {
    color: black;
    font-size: 100px;
}


.vendordiv {

    width: 200px;
    color: black;
    background-color: lavender;
    border-radius: 25px;
    padding: 10px;
    margin-left: 45%;
    margin-bottom: 5px;
}
</style>