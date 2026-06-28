// @Maintainer User Community
// @Released 2026-06-27
// @Author yasbtw
// @Description Rotational swing with a smooth rubbery pendulum motion, locked X/Y.

DeclareLightworksEffect ("Rotational Swing", "Stylize", "Video artefacts", "Center-locked rotational pendulum swing with no positional drift or stretching", kNoFlags);

DeclareInput (Fg);
DeclareMask;

DeclareFloatParam (Strength, "Swing Amount", kNoGroup, kNoFlags, 0.5, -1.0, 1.0);
DeclareFloatParam (Speed, "Speed", kNoGroup, kNoFlags, 1.0, 0.2, 2.5);
DeclareFloatParam (Rubber, "Rubbery Bounce", kNoGroup, kNoFlags, 0.5, 0.0, 1.0);

DeclareFloatParam (_Progress);
DeclareFloatParam (_Length);
DeclareFloatParam (_OutputAspectRatio);

#define iTime (_Length * _Progress)

DeclareEntryPoint (RotationalSwing){
   float t = iTime * Speed * 6.0;
   float swing = sin (t);
   float rubberWave = sin (t * 2.0) * 0.25 * Rubber;
   float angle = (swing + rubberWave) * 0.35 * Strength;
   float cosA = cos (angle);
   float sinA = sin (angle);
   float2 uv = uv1 - 0.5.xx;
   uv.x *= _OutputAspectRatio;
   float2 rotatedUV;
   rotatedUV.x = uv.x * cosA - uv.y * sinA;
   rotatedUV.y = uv.x * sinA + uv.y * cosA;
   rotatedUV.x /= _OutputAspectRatio;
   rotatedUV += 0.5.xx;
   float2 mirrored_xy = 1.0.xx - abs (frac (rotatedUV * 0.5) * 2.0 - 1.0.xx);
   return lerp (0.0.xxxx, tex2D (Fg, mirrored_xy), tex2D (Mask, uv1).x);
}