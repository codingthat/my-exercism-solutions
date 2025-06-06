class Bob {
  hey(message) {
    if (message.trim() === '') { return 'Fine. Be that way!'; }
    else if (message.match(/[A-Z]/) && message.toUpperCase() === message) { return 'Whoa, chill out!'; } // add caps-contains regex
    else if (message[message.length - 1] === '?') { return 'Sure.'; }
    return 'Whatever.';
  }
}

export default Bob;