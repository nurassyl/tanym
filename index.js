let globalName = 'Nurassyl';

function getName(name = null) {
  return name || globalName;
}

setTimeout(() => {
  console.log(getName())
}, 5000)

setInterval(() => {
  console.log(getName('Guldana'))
}, 1000)

