<template>
        <v-dialog
        transition="dialog-top-transition"
        max-width="600">
        <template v-slot:activator="{ props }">
          <v-btn
          size="small"
            color="secondary"
            v-bind="props"
            
          >Регистрация</v-btn>
        </template>
      
<!--         <template v-slot:default="dialog"> -->
          
          <v-card class="sign" title="Создать аккаунт" subtitle="для получения доступа">
            <!-- <v-card-title>создать аккаунт</v-card-title> -->

  <v-form class="form-signup pt-9 pb-5" @submit.prevent="signup">
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
    
    <div>

    </div>
  </v-form>
  <v-card-actions class="pa-7 pt-0">
      <v-spacer></v-spacer>
<v-btn size="large" type="submit" class="btn btn-primary ">Отправить</v-btn>
    </v-card-actions>
            </v-card>
        <!-- </template> -->
      </v-dialog>
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