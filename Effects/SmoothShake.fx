
// @Maintainer User Community
// @Released 2026-06-27
// @Author yasbtw
// @Description Smooth Shake Effect.

DeclareLightworksEffect ("Smooth Shake", "Stylize", "Video artefacts", "Decoupled horizontal swing and vertical bounce with micro-zoom", kNoFlags);

//-----------------------------------------------------------------------------------------//
// Inputs & Parameters
//-----------------------------------------------------------------------------------------//

DeclareInput (Fg);
DeclareMask;

DeclareFloatParam (Strength, "Overall Strength", kNoGroup, kNoFlags, 0.4, 0.0, 3.0);
DeclareFloatParam (Speed, "Speed", kNoGroup, kNoFlags, 1.0, 0.2, 2.5);
DeclareFloatParam (ZoomAmount, "Dynamic Zoom", kNoGroup, kNoFlags, 0.3, 0.0, 1.0);

DeclareFloatParam (_Progress);
DeclareFloatParam (_Length);

#define iTime (_Length * _Progress)

DeclareEntryPoint (Shake){
   float t = iTime * Speed * 12.0;
   float pulseZoom = 1.0 + (sin(t * 0.5) * 0.02 * ZoomAmount) + (ZoomAmount * 0.03);
   float2 uv = ((uv1 - 0.5.xx) / pulseZoom) + 0.5.xx;
   float shakeX = sin(t * 1.3) * cos(t * 0.7);
   float shakeY = cos(t * 0.95) * sin(t * 0.4);
   float2 offset = float2(shakeX, shakeY) * (Strength * 0.04);
   float2 xy = uv + offset;
   float2 mirrored_xy = 1.0.xx - abs(frac(xy * 0.5) * 2.0 - 1.0.xx);
   return lerp (0.0.xxxx, tex2D (Fg, mirrored_xy), tex2D (Mask, uv1).x);
}