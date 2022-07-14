<script setup lang="ts">
import LoginRepo from '../Repos/LoginRepo';
//import LoginRepo from '../Repos/LoginRepo'
//import LoginUserRepo from '../Repos/LoginUserRepo'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../store/useUserStore'

const router = useRouter();
const store = useUserStore();
let username = ref<string>('');
let password = ref<string>('');


async function login() {

  if (username.value == '' || password.value == '') {
    alert('Username or Password cannot be empty')
  }
  else {

    try {

      let result = await LoginRepo.login(username.value, password.value)
      store.setToken(result.token);
      console.log(result)
      router.push('clientRegister')

    } catch (error) {

      console.log(error)
    }


  }
}

</script>

<template>
  <div>

    <video autoplay muted loop id="myVideo">
      <source src="../assets/gradient.mp4" type="video/mp4">
    </video>

    <div id="TemplateOne">
      <div>
        <img src="../assets/mobiusstrip.gif" alt="Mobius Strip" id="MobiusStrip" />
      </div>

      <h1>Partner Portal Login</h1>

      <div>
        <a href="" id="RegisterLink">Dont Have an account? Click here to Register</a>
      </div>

      <div>



        <div id="DivTextBoxes">
          <img alt="user icon" src="../assets/user.png" id="textboxicon" />
          <input type="text" class="textboxes" id="usernameinput" placeholder="Username" v-model="username" required />
        </div>

      </div>

      <div>
        <div id="DivTextBoxes">
          <img alt="Password icon" src="../assets/lock.png" id="textboxicon">
          <input type="password" class="textboxes" id="password" placeholder="Password" v-model="password" required />


        </div>

        <div>
          <input type="checkbox" id="rememberme" />
          <label for="rememberme" id="remebermelabel">Remember Me</label>
        </div>

        <div>
          <button @click="login" type="submit" form="LoginForm" value="Login" text="Login"
            id="loginButton">Login</button>
        </div>

        <div>
          <a href="" id="RegisterLink"> Forgot Your Password? </a>
        </div>

      </div>

    </div>

  </div>


</template>

<style>
#body {
  display: flex;
  justify-content: center;

  background-color: rgb(66, 66, 133);

}

/*

#myVideo {
  position: fixed;
  right: 0;
  bottom: 0;
  min-width: 100%;
  min-height: 100%;
}
#TemplateOne{
margin-top: 30%;
background: rgba(255, 255, 255, 0.23);
border-radius: 16px;
box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
backdrop-filter: blur(6px);
-webkit-backdrop-filter: blur(6px);
border: 1px solid rgba(255, 255, 255, 0.05);

 width:100%;
 padding:30px;
}
#app {

  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
h1{
  color: white;
}

#radioLabel{
  color:white;
 font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
#PartnerRadioButton, #ClientRadioButton{
  cursor: pointer;
  margin-left: 20px;
  
}

.radiobuttongroup{
  cursor:hand;
  padding:10px 24px 10px 10px;
   display: block;
}


#textboxicon{
  height:27px;
  width:25px;
  margin-right:5px;
 margin-bottom: 0;

 
}
.textboxes{

  height:30px;
  width: 80%;
  border: 0;
  outline-style: none;
  background-color: rgb(228, 228, 228); 
 
  color:gray;
  
}

#DivTextBoxes{

  padding-top: 5px;
  margin-top: 10px;
  height:40px;
  width:100%;
  border-radius: 25px;
   background-color: rgb(228, 228, 228); 
  
   

  
}

#RegisterLink{
  font-size: 10px;
  width:fit-content;
  outline-style: none;
  text-decoration: none;
 
}

#loginButton{
  border: none;
  height: 30px;
  width:100px;
  border-radius: 25px;
  margin-top: 10px;
  margin-bottom: 10px;
   background-color: rgb(228, 228, 228); 
  
}

#loginButton:hover{
  background-color: rgb(180, 248, 180);
}

#remebermelabel{
  margin-top:5px;
  color:rgba(69, 67, 168, 0.822);
  font-size: 10px;
}

#rememberme{
    margin-top:10px;
}

#MobiusStrip{

  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 100%;
  height:200px;
}
form{
display:flex;
  justify-content:center;
 
} */
</style>
