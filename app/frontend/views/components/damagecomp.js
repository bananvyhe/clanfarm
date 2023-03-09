import { ref, reactive } from 'vue'
export function damagecomp() {
  const damageData = reactive({
    basedamage: 110,
    lvl: 1,
    hit: 0   
  })

  function hitcalc(){
    damageData.hit = (((damageData.basedamage * (damageData.lvl/10 ))  )* (Math.random() * (0.120 - 0.0200) + 0.3).toFixed(2)*10).toFixed()     
  }
  return {
    hitcalc,
    damageData,
    
  }
}

//   methods: {
//     hitcalc(){
//       this.hit = (((this.basedamage * (this.lvl/10 ))  )* (Math.random() * (0.120 - 0.0200) + 0.3).toFixed(2)*10).toFixed()
//       var m1 = gsap.timeline();
//       m1.from(".infodmg",{
//          y:"10px",
//         opacity: 1, 
//       })
//       .to(".infodmg",{
//         opacity: 0, 
//         y:"-40px",
//         duration: 6,
//       })
//     }
//   },
// }
 
