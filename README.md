# Charcoal
Create custom particles in vanilla minecraft using this vanilla shader resource pack

## Try it out
If you want to try it out before fully setting it up, you can do so

1. **Download** this repo by clicking on the green `Code` button and then on `Download ZIP`
2. Place the downloaded `.zip` file into your `resourcepacks` folder
3. Ingame, **select the resource pack**
4. Run this command:
    ```mcfunction
    particle entity_effect .12 .36 .15 0.98
    ```
You should see a green `12` flying up from your feet

## How to set up
1. Move the [shader file](assets/minecraft/shaders/core/particle.vsh) into your resource pack at the same location (`assets/minecraft/shaders/core/particle.vsh`)
2. Move the [particle textures](assets/minecraft/textures/particle) into your resource pack at the same location (`assets/minecraft/textures/particle`)
3. **Modify** one of the 99 placeholder textures in **all of the particle texture files**, the files `effect_7` to `effect_0` represent the **evolution of the particle over time**

**Remember the numbers on the placeholder texture** you modified, the numbers are the **X and Y offset** from the original texture and are required for the `particle` command

Use the **offset numbers** in the particle command like this:
```mcfunction
particle entity_effect .XY .36 .15 0.98
```
_Replace X and Y with the X and Y offset where you placed your custom particle texture_

You can use all [other features of the particle command](https://minecraft.wiki/w/Commands/particle) just like normal aswell _(speed, amount, location, ...)_

## Compatability
- This pack **requires minecraft 1.20.5** or higher _(Tested in 23w14a)_
- This pack is **incompatible** with **modded shaders**
- This pack **should work** with most other mods (Like Optifine/Sodium)
- **Compatible with other vanilla shaders** that dont replace the `particle.vsh` file

_If another vanilla shader resource pack modifies the `particle.vsh` file, you should be able to easily merge it by adding the new variables (annotated using comments) and the lower block of code (annotated using comments) **at the end** of the other shader's `main` function_

---
[![PuckiSilver on GitHub](https://raw.githubusercontent.com/PuckiSilver/static-files/main/link_logos/GitHub.png)](https://github.com/PuckiSilver)[![PuckiSilver on modrinth](https://raw.githubusercontent.com/PuckiSilver/static-files/main/link_logos/modrinth.png)](https://modrinth.com/user/PuckiSilver)[![PuckiSilver on PlanetMinecraft](https://raw.githubusercontent.com/PuckiSilver/static-files/main/link_logos/PlanetMinecraft.png)](https://planetminecraft.com/m/PuckiSilver)[![PuckiSilver on PayPal](https://raw.githubusercontent.com/PuckiSilver/static-files/main/link_logos/PayPal.png)](https://paypal.me/puckisilver)
