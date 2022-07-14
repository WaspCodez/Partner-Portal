<script setup lang="ts">
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://vuejs.org/api/sfc-script-setup.html#script-setup
import { useUserStore } from './store/useUserStore';
import { onMounted } from 'vue';
import { useRouter } from 'vue-router';

const store = useUserStore();
const router = useRouter();
onMounted(() => {
  const token = localStorage.getItem('login_token');

  if (token) {
    store.setToken(token);
    router.push('clientRegister');
  }
})

</script>

<template>
  <router-view></router-view>


</template>




<style>
#loginbody {
  display: flex;
  justify-content: center;

  background-color: rgb(66, 66, 133);

}

#myVideo {
  position: fixed;
  right: 0;
  bottom: 0;
  min-width: 100%;
  min-height: 100%;
}

#TemplateOne {
  margin-top: 10%;
  background: rgba(255, 255, 255, 0.23);
  border-radius: 16px;
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(6px);
  -webkit-backdrop-filter: blur(6px);
  border: 1px solid rgba(255, 255, 255, 0.05);
  margin-left: 700px;
  width: 400px;
  padding: 30px;
}

#app {

  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px; */
}

h1 {
  color: white;
}

#radioLabel {
  color: white;
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#PartnerRadioButton,
#ClientRadioButton {
  cursor: pointer;
  margin-left: 20px;

}

.radiobuttongroup {
  cursor: hand;
  padding: 10px 24px 10px 10px;
  display: block;
}


#textboxicon {
  height: 27px;
  width: 25px;
  margin-right: 5px;
  margin-bottom: 0;


}

.textboxes {

  height: 30px;
  width: 80%;
  border: 0;
  outline-style: none;
  background-color: rgb(228, 228, 228);

  color: gray;

}

#DivTextBoxes {

  padding-top: 5px;
  margin-top: 10px;
  height: 40px;
  width: 100%;
  border-radius: 25px;
  background-color: rgb(228, 228, 228);




}

#RegisterLink {
  font-size: 10px;
  width: fit-content;
  outline-style: none;
  text-decoration: none;

}

#loginButton {
  border: none;
  height: 30px;
  width: 100px;
  border-radius: 25px;
  margin-top: 10px;
  margin-bottom: 10px;
  background-color: rgb(228, 228, 228);

}

#loginButton:hover {
  background-color: rgb(180, 248, 180);
}

#remebermelabel {
  margin-top: 5px;
  color: rgba(69, 67, 168, 0.822);
  font-size: 10px;
}

#rememberme {
  margin-top: 10px;
}

#MobiusStrip {

  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 100%;
  height: 200px;
}
</style>