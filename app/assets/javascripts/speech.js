var dom = document.cloneNode(true);
console.log(dom);

var r = new Readability(dom);
console.log(r);
var article = r.parse();
console.log(article.title);


function speak(){
  var msg = new SpeechSynthesisUtterance();
  // var text = sample_text();
  var text =
  document.getElementById('title').innerHTML + document.getElementById('text').innerHTML;
  msg.text = text;

  msg.rate = 1.25;
  speechSynthesis.speak(msg);
}

function cancel() {
  speechSynthesis.cancel();
}

function pause() {
  speechSynthesis.pause();
}

function resume() {
  speechSynthesis.resume();
}
