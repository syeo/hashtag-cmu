Home = require('./home/home.component.cjsx')
React = require('./react')

# HomeExampleData.init()

# ChatExampleData.init() # load example data into localstorage

# ChatWebAPIUtils.getAllMessages();

React.render(
    <Home />,
    document.getElementById('content')
);
