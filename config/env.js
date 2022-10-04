const dotenv = require("dotenv");

const setup = (env) => {
    if(env == "test"){
        return dotenv.config({path: "test.env"});
    }

    return dotenv.config();
}

module.exports = setup;