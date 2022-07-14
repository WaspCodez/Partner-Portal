<script setup lang="ts">

import LoginRepo from '../Repos/LoginRepo';
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router';
import { useUserStore } from '../store/useUserStore';
import Users from '../models/Users';
import { mapGetters } from 'pinia';

const router = useRouter();
const store = useUserStore();

//getting todays date

var today = new Date();
var dd = String(today.getDate()).padStart(2, '0');
var mm = String(today.getMonth() + 1).padStart(2, '0');
var yyyy = today.getFullYear();
var hh = today.getHours();
var mins = today.getMinutes();
var Seconds = today.getSeconds();

let todayDay = yyyy + '-' + mm + '-' + dd + ' ' + hh + ':' + mins + ':' + Seconds + '.000000';

let modalUsername = ref<string>('');
let modaluserId = ref<number>();
let modalDisplayName = ref<string>('');
let modalEmail = ref<string>('');
let modalPassword = ref<string>('');

let errormsg = "";

interface User_Details {
  id: number,
  username: string,
  email: string,
  password: string,
  time_of_login: Date,
  display_name: string,
  //   partner_id:number
}

let UserDetails = ref<User_Details[]>([]);

onMounted(async () => {


})

async function addUser() {


  if (modalUsername.value == '' || modalDisplayName.value == '' || modalEmail.value == '' || modalPassword.value == '') {
    errormsg = "No Fields Can Remain Blank ";
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

  } else if (modalUsername.value.length < 3) {
    errormsg = "Username is too short";
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
  } else if (modalDisplayName.value.length < 3) {
    errormsg = "Displayname is too short";
    let msg = document.getElementById("errorNotification3");
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
  } else if (modalDisplayName.value.match(/\d+/g)) {
    errormsg = "Display Name Cannot have Numbers";
    let msg = document.getElementById("errorNotification4");
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
  } else if (!modalEmail.value.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)) {
    errormsg = "Invalid Email Address";
    let msg = document.getElementById("errorNotification5");
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
  } else if (modalPassword.value.length < 11) {
    errormsg = "Password needs to be 11 Charachters";
    let msg = document.getElementById("errorNotification6");
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
      let users: Users = {
        username: modalUsername.value,
        display_name: modalDisplayName.value,
        email: modalEmail.value,
        password: modalPassword.value,
        // time_of_login: today
      };
      await LoginRepo.addUser(users)
      modalUsername.value = "";
      modalDisplayName.value = "";
      modalEmail.value = "";
      modalPassword.value = "";
      let msg = document.getElementById("errorNotification7");
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
    catch (error) {

      console.log(error)
    }
  }

}

function addclient() {

  router.push('clientAddUser')
}

function userRegister() {
  router.push('userRegister')
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

  <div id="mySidenav" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" @click="closeNav()">&times;</a>
    <a href="#" @click="clientRegister()">Client Register</a>
    <a href="#" @click="userRegister()">View Users</a>
    <a href="#" @click="addclient">Add Client</a>
    <a href="#" @click="addUserNav()">Add User </a>
  </div>

  <!-- Use any element to open the sidenav -->
  <span @click="openNav()">☰ Menu</span>
  <br>
  <div id="errorNotification1"> </div>

  <div id="errorNotification2"> </div>

  <div id="errorNotification3"> </div>

  <div id="errorNotification4"> </div>

  <div id="errorNotification5"> </div>

  <div id="errorNotification6"> </div>

  <div id="errorNotification7"> </div>

  <div class="addUserDiv">
    <img src="../assets/adduserimage.png" />
    <h1 class="adduserHeading"> Add User </h1>
    <div id="DivTextBoxes">
      <img src="../assets/user.png" id="usericon" />
      <input type="text" placeholder="username" class="textboxes" v-model="modalUsername" />
    </div>

    <div id="DivTextBoxes">
      <input type="text" placeholder="Display Name" class="textboxes" v-model="modalDisplayName" />
    </div>

    <div id="DivTextBoxes">
      <input type="text" placeholder="Email " class="textboxes" v-model="modalEmail" />
    </div>

    <div id="DivTextBoxes">
      <img src="../assets/lock.png" id="usericon" />
      <input type="text" placeholder="Password " class="textboxes" v-model="modalPassword" />
    </div>

    <div>
      <br>
      <button class="bn632-hover bn20" @click="addUser">Add Client </button>
    </div>



  </div>


</template>

<style>
.addUserDiv {

  width: 50%;
  background-color: lavender;
  border-radius: 25px;
  margin-top: 50px;
  margin-left: 550px;
  padding-top: 20px;
  padding-bottom: 20px;
  padding-left: 20px;
  padding-right: 20px;

}

.addbtn {
  width: 20%;
}

.adduserHeading {
  color: black;
  font-size: 50px;
}

.errorNotification {
  padding: 10px;
  margin-top: 50px;

}
</style>