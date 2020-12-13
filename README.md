# planning_poker
Simple web-targeted Planning Poker app built with Flutter. Website available here: [nickmurray.dev/poker](https://nmur.github.io/planning_poker/index.html#/).  
  
Just enter your name, select an estimate, and reveal all cards when everyone's ready.    
    
![Poker app preview](https://i.imgur.com/4QhEobT.png)

# Update website hosted on Github Pages
1. Checkout `master` branch.
2. Install [peanut](https://pub.dev/packages/peanut#flutter) for Flutter with the following command:  
```flutter pub global activate peanut```
3. Build and update the hosted web page with the following command:  
```flutter pub global run peanut:peanut```
4. Checkout the `gh-pages` branch.
5. Push to `origin`.
