<template>
  <v-form class="form-signup" @submit.prevent="signup">
    <div class="alert alert-danger" v-if="error">{{ error }}</div>
    <div class="form-group"> 
      <!-- <label for="email">Зарегистрироваться</label> -->
      <v-text-field v-model="email" :rules="emailRules"   id="email" label="email@example.com" ></v-text-field>
    </div>
    <div class="form-group">
      <!-- <label for="password">Придумайте пароль</label> -->
      <v-text-field v-model="password" type="password" id="password" label="Придумайте пароль"></v-text-field>
    </div>
    <div class="form-group">
      <!-- <label for="password">Повторите пароль</label> -->
      <v-text-field v-model="password_confirmation" :rules="confirmRules" type="password" id="password_confirmation" label="Повторите пароль"></v-text-field>
    </div>
    <v-btn type="submit" class="btn btn-primary my-3">Отправить</v-btn>
    <div>

{{ex7}}
<v-radio-group  v-model="ex7">
  <v-radio label="Radio 1" value="1" ></v-radio>
  <v-radio label="Radio 2" value="2"></v-radio>
  <v-radio label="Radio 3" value="3"></v-radio>
</v-radio-group>
 <v-slider></v-slider>
    </div>
  </v-form>
</template>

<script setup lang="ts">
  import { useLogStore } from '../../store.js'
 
  import { ref, reactive, computed } from 'vue';
  
  // import { mapState } from 'pinia'
  // import { mapActions } from 'pinia' 
  // import { useLogStore } from 'store.js'
// export default {
  // name: 'Signup',
  // data () {
  //   return {
  //     confirmRules: [
  //       v => !!v || 'нужно ввести пароль',
  //       v => v.length >= 5 || 'Пароль должен содержать более 6 символов',
  //                   // v => (v || '').indexOf(' ') < 0 ||  'Пробелов не должно быть'
  //       v => v == this.password || "Пароли не совпадают"
  //     ],  
  //     emailRules: [
  //       v => !!v || 'E-mail необходим для регистрации',
  //       v => /.+@.+\..+/.test(v) || 'E-mail введен некорректно',
  //     ],      
  //     email: '',
  //     password: '',
  //     password_confirmation: '',
  //     error: ''
  //   }
  // },
const ex7 = ref()
 
  const email = ref()
  const password = ref()
  const password_confirmation = ref()
  const error = ref()
  const emailRules = reactive([
        v => !!v || 'E-mail необходим для регистрации',
        v => /.+@.+\..+/.test(v) || 'E-mail введен некорректно',
      ])
  const confirmRules = reactive([
        v => !!v || 'нужно ввести пароль',
        v => v.length >= 5 || 'Пароль должен содержать более 6 символов',
                    // v => (v || '').indexOf(' ') < 0 ||  'Пробелов не должно быть'
        v => v == this.password || "Пароли не совпадают"
      ])
 
  // created () {
  //   this.checkSignedIn()
  // },
  // updated () {
  //   this.checkSignedIn()
  // },


  // computed: {  
  //   ...mapState(useLogStore, {
  //     loastat: "thisloa",
  //   }),
 
  // },   

  function signup(){
      plain
      .post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation, loa: this.loastat })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))    

  } 
  // methods: {
  //   // ...mapActions(useLogStore, ["unsetLoa"]), 
   
  //   // ...mapActions(useLogStore, ["setCurrentUser"]),     
     
  //   signup () {
  //     // console.log()
  //     this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation, loa: this.loastat })
  //       .then(response => this.signupSuccessful(response))
  //       .catch(error => this.signupFailed(error))
  //   },
  //   signupSuccessful (response) {
  //     this.unsetLoa()
  //     if (!response.data.csrf) {
  //       this.signupFailed(response)
  //       return
  //     }
  //     this.$http.plain.get('/me')
  //       .then(meResponse => {
  //         // this.$store.commit('setCurrentUser', { currentUser: meResponse.data, csrf: response.data.csrf })
  //         this.setCurrentUser(meResponse.data, response.data.csrf)
  //         this.error = ''
  //         // this.$router.replace('/todos')
  //         this.$router.replace('/join')
  //       })
  //       .catch(error => this.signinFailed(error))

  //     // this.logined()
  //     // localStorage.csrf = response.data.csrf
  //     // localStorage.signedIn = trues
  //     // this.$router.replace('/todos')
  //     this.$router.replace('/')
  //   },
  //   signupFailed (error) {
  //     console.log(error)
  //     this.error = (error.response && error.response.data && error.response.data.error) || error.data.errors
  //     delete localStorage.csrf
  //     delete localStorage.signedIn
  //   },
  //   checkSignedIn () {
  //     if (localStorage.signedIn) {
  //       // this.$router.replace('/todos')
  //       this.$router.replace('/')
  //     }
  //   }
  // }
// }
</script>

<style lang="css">
.form-signup {
  width: 70%;
  max-width: 500px;
  padding: 10% 15px;
  margin: 0 auto;
}
</style>