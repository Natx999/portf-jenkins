
const log = require("json-log").log;
const config = require('config')

log.info("Starting rando app!");

async function main() {
  colors = ["red", "orange", "yellow", "green", "blue", "purple"]
  while (true) {
    for (i = 0; i < config.count; i++) {
      num = getRandomInt(config.maxNum)
      color = colors[getRandomInt(6)]
      log.info("Random data", { rando_details: { color: color , number: num}, time: new Date().toISOString()});
    }
    await sleep(config.interval*1000);
  }
}

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

function getRandomInt(max) {
  return Math.floor(Math.random() * max);
}

main();