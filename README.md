# That Story About Zeldo
Lank wakes up from a good night's rest only to find Hi-roll in danger! You gotta
help him save the Land of Hi-roll from the forces of evil.

Enjoy my game. Made with <3 in PICO-8.

## TODOS (For the developer):

### Demo sprint!
- TODO: Fix title screen early btn press bug.
- TODO: Shield retract (shield timeout/don't kill immediately).
- TODO: Navy go back home.
- TODO: Create wall that boomerang can go through!
- TODO: How should the game over screen be designed?
- TODO: Sword, shield, and bow persist through rooms.
- TODO: Make the chicken enemy go crazy.
- TODO: Make some good music.

### item sprint:
- TODO: Continue bomb mechanics.
- TODO: Arrow bump bomb or arrow grab bomb.
- TODO: Boomerang bump bomb or boomerang return bomb.

### engine sprint:
- TODO: Just make bombs better in general.

### enemy sprint:
- TODO: Make the bat enemy do something
- TODO: Interaction with Top enemy and write plans for other enemies.

### story sprint
- TODO: Finish the basic map transitions.

## Things that are done:
- What should go into a demo of the game?
- Make ma work correctly for interactable things.
- Make ma work for items.
- Fix the boomerang timeout problem.
- Make a flippable attribute on all items.
- Refine the top enemy more.
- Tbox pop up and down, or think about transition.
- Fix sign artifact bug (when sign is gone, trigger still exists).
- Pot collide with walls.
- Boomerang retract/use item.
- Work on house transitions again.
- Finish house transitions.
- Pause game on tbox.
- Fix tbox screen pause
- Pause game on room transition.
- Token saving sprint, (items and enemies). Get down to 7500!
- Continue shovel mechanics.
- work on shovel animation.
- Disable inventory on room transition.
- Pause game on banjo play.
- Tbox triggers should work.
- Think about player arm movement (above head? ...).
- Banjo play song.
- Plant throwing. (basic version)
- Chicken throwing. (basic version)
- Held item persists through rooms.
- Bomb throwing. Bomb should be similar to pickupable items.
- Inventory spacing left and right correct.
- Fix inventory pixel off problem.
- Think about state name with tl. All nodes have optional names and time state.
- design menu actor area/transitions. this is done by fading now.
- create title screen.
- Create a more modular view.
- fix tbox double press bugs.
- More efficient trigger, only interact with player.
- create zcls, that uses rectfill to fill the screen (within cropped area).
- cell shading only for sub items.
- Fix ma player 2 parts (for enemies). Fixed with modular view.
- no screen shake when enemy hits enemy/house.
- Think about text interaction more. Only Lank is to the left.
- Separate tbox speaker.
- Connect tbox with menu actors.
- go through sprite file optimizations.
- Make tbox use gun_vals.
- give player money
- Work on sword & shield walking.
- ma don't move if pl not moving (look at dx/dy)
- create power square item.
- tbox only interact if in interact state.
- create a chicken object.
- make bombs work
- make and tweak an after stun timer.
- make item (boomerang) recoil timer.
- copy logic for contains, between trigger and col (or remove it from col).
- house needs to clean up after itself.
- see if caden can fetch/merge.
- delete old map room logic.
- when running out of energy
- create palace map.
- gun vals number
- optimize gun nums again
- player banjo walk
- player no run
- player item in front.
- try the 'just around player' status thing (caden idea.)
- think about sub table gun_vals cache. don't want. problem was state.
- fix enemy share state bug
- tl update don't use t(), or fix pausing.
- create stateful draw.
- tl update return next.
- tl takes no parameters? debate about this idea.
- shield house collision.
- room loading draw on load.
- map rooms need separate init functions.
- item selection sprites, based on pl's items.
- enemy needs to collide with house correctly
- enemy needs to be stunned correctly again.
- enemy collide with screen edge.
- field fix up. field and gravep connect better.
- think about connecting map logic.
- connect up grave dungeon.
- connect up castle
- change drawing functions to work with tl better. incorporate tl even more.
- no double draw items
- create boomerang.
- screen shake when hitting player.
- pl item shakes with pl.
- create separate logic between doors and map.
- tl and actor work together better.
- add nf (nothing function) to the gun vals logic.
- make tl optional.
- fix string or value bug in gun nums.
- make actor update more simple (use tl?).
- do we need a begin init function? (no, embed tl can handle that).
- fix tbox arrow sprite offset.
- create actor/parent more simple? no. it is good.
- create actor adds actor to g_attach.
- rethink items again.
- create power square variable.
- make enemy health bar.
- make the top 'tired' bar work.
- connect the map.
- make the code size smaller in menu.
- token cleanup on status bars
- menu actor name and different backgrounds. opted with black background.
- nice functions to integrate with menu actors. think i did this.
- create card transitions.
- change the top of the screen (new layout).
- menu enemy support must be better.
- make area information (if no enemy). opted no, i can have signs.
- tl embedded tl. decided on no! Then I later implemented it!
- tbox pause the game. should it? if so, do it. it is right now.
- make a sign
- create 2 parts of lank (feet and arms).
- how should the title screen be designed?
