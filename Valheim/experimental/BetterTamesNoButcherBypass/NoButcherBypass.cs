using System;
using BepInEx;
using HarmonyLib;

namespace VspGamer.BetterTamesNoButcherBypass
{
    [BepInPlugin("vspgamer.bettertames.no_butcher_bypass", "BetterTames - Protect from Butcher Knife", "0.1.0")]
    [BepInDependency("xtav1m.BetterTames", BepInDependency.DependencyFlags.HardDependency)]
    public sealed class NoButcherBypass : BaseUnityPlugin
    {
        private void Awake()
        {
            // BetterTames 0.9.0: TryDown() checks IsProtected(zdo) first,
            // then KilledWithButcherKnife(character). Making the latter false
            // preserves protection for opted-in pets, while unprotected animals
            // can still be slaughtered as in vanilla.
            var protectionType = AccessTools.TypeByName("BetterTames.Scripts.Protection.Protection");
            if (protectionType == null)
            {
                Logger.LogError("BetterTames Protection type not found; patch not installed.");
                return;
            }
            var target = AccessTools.Method(protectionType, "KilledWithButcherKnife");
            if (target == null)
            {
                Logger.LogError("BetterTames KilledWithButcherKnife not found; patch not installed.");
                return;
            }
            var patch = AccessTools.Method(typeof(NoButcherBypass), nameof(ReturnFalse));
            try
            {
                new Harmony("vspgamer.bettertames.no_butcher_bypass").Patch(target, prefix: new HarmonyMethod(patch));
                Logger.LogInfo("Butcher-knife protection bypass disabled for protected tames.");
            }
            catch (Exception ex)
            {
                Logger.LogError("Could not patch BetterTames: " + ex);
            }
        }

        private static bool ReturnFalse(ref bool __result)
        {
            __result = false;
            return false;
        }
    }
}
