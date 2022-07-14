<script setup lang="ts">

import ClientRepo from '../Repos/ClientRepo';
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../store/useUserStore'
import Repos from '../Repos/Repos';
import ClientRepos from '../Repos/ClientRepos';
import Client from '../models/Client';

const router = useRouter();
const store = useUserStore();

let username = ref<string>('');
let errormsg = '';

interface Client_Details {
  id: number,
  name: string
}

let clientDetails = ref<Client_Details[]>([]);


function addclient() {

  router.push('clientAddUser')
}

function userRegister() {
  router.push('userRegister')
}

async function adduser() {
  
  if (username.value == '') {
    errormsg = "Field Cant Remain Blank ";
    let msg = document.getElementById("errorNotification1");
    msg.style.display = "block";
    msg.style.backgroundColor = "red";
    msg.style.width = "200px";
    msg.style.padding = "20px";
    msg.style.float = "left";
    msg.style.borderRadius = "25px";
    let displaymsg = msg.innerHTML = errormsg;
    setTimeout(() => {
      msg.style.display = "none";

    }, 5000);

  } else if (username.value.length < 3) {
    errormsg = "Client name is too short";
    let msg = document.getElementById("errorNotification2");
    msg.style.display = "block";
    msg.style.backgroundColor = "red";
    msg.style.width = "200px";
    msg.style.padding = "20px";
    msg.style.float = "left";
    msg.style.borderRadius = "25px";
    let displaymsg = msg.innerHTML = errormsg;
    setTimeout(() => {
      msg.style.display = "none";

    }, 5000);

  } else {
    try {
      let client: Client = {
        name: username.value
      };

      clientDetails = await ClientRepos.searchClientByUsername(username.value)


      if(!clientDetails.value){
        username.value = "";
      let msg = document.getElementById("errorNotification3");
      msg.style.display = "block";
      msg.style.backgroundColor = "green";
      msg.style.width = "200px";
      msg.style.padding = "20px";
      msg.style.float = "left";
      msg.style.borderRadius = "25px";
      msg.innerHTML = "Username Exists! ";
      setTimeout(() => {
        msg.style.display = "none";

      }, 5000);
      } else{ 
await ClientRepos.addClient(client)
      username.value = "";
      let msg = document.getElementById("errorNotification3");
      msg.style.display = "block";
      msg.style.backgroundColor = "green";
      msg.style.width = "200px";
      msg.style.padding = "20px";
      msg.style.float = "left";
      msg.style.borderRadius = "25px";
      msg.innerHTML = "User Saved";
      setTimeout(() => {
        msg.style.display = "none";

      }, 5000);
      }
 
    }
    catch (error) {
      alert(error)
      console.log(error)

    }
  }
}
function addUserNav() {
  router.push('addUser')
}

function clientRegister() {
  router.push('clientRegister')
}

function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

/* Set the width of the side navigation to 0 */
function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>

<template>
  <span @click="openNav()">☰ Menu</span>
  <br>
  <br>
  <div id="errorNotification1"> </div>
  <div id="errorNotification2"> </div>
  <div id="errorNotification3"> </div>

  <h1 class="addclientlabel">Add Client</h1>
  <div id="mySidenav" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" @click="closeNav()">&times;</a>
    <a href="#" @click="clientRegister()">Client Register</a>
    <a href="#" @click="userRegister()">View Users</a>
    <a href="#" @click="addclient">Add Client</a>
    <a href="#" @click="addUserNav()">Add User </a>
  </div>



  <div>

    <table class="addclienttbl">

      <tr>
        <td>
          <img src="../assets/userProfile.gif" atl="turning profile" class="rotatinghead" />
        </td>

        <td>
          <div id="DivTextBoxes">
            <img src="../assets/user.png" id="usericon" />
            <input type="text" placeholder="Username" class="textboxes" v-model="username" />
            <p>{{ username }}</p>
          </div>
          <div>
            <button @click="adduser" class="bn632-hover bn20">Add Client</button>
          </div>

        </td>
      </tr>
    </table>
  </div>

</template>

<style>
table {
  margin-left: 200px;
  width: 86%;

}

.addclienttbl {
  margin-top: 5%;
}

.rotatinghead {
  margin-top: 50px;
  margin-left: 0px;
  width: 20%;
  height: 40%;
}

#usericon {
  width: 25px;
  height: 25px;
}

span {
  top: 0;
}

.addclientlabel {
  font-size: 100px;
  color: black;
}
</style>