function [L, a, b] = sRGB2Lab_Lindbloom(Image)
    % Normalisation [0,255]->[0,1]
    I = double(Image) / 255;

    % Conversion de l'espace colorimétrique sRGB en espace colorimétrique XYZ (Lindbloom)
    I_Comp = (I <= 0.04045) .* I / 12.92 + (I > 0.04045) .* ((I + 0.055) / 1.055) .^ (2.4);

    % Conversion de l'espace colorimétrique XYZ en espace colorimétrique Lab (Lindbloom)
    X = I_Comp(:, :, 1) * 0.4124564 + I_Comp(:, :, 2) * 0.3575761 + I_Comp(:, :, 3) * 0.1804375;
    Y = I_Comp(:, :, 1) * 0.2126729 + I_Comp(:, :, 2) * 0.7151522 + I_Comp(:, :, 3) * 0.0721750;
    Z = I_Comp(:, :, 1) * 0.0193339 + I_Comp(:, :, 2) * 0.1191920 + I_Comp(:, :, 3) * 0.9503041;

    % Valeurs de référence pour l'illuminant D65
    X1 = 0.9504;
    Y1 = 1;
    Z1 = 1.0888;

    x = X / X1;
    Y = Y / Y1;
    Z = Z / Z1;

    epsilon = 0.008856;
    kappa = 903.3;

    fx = (X > epsilon) .* X .^ (1 / 3) + (X <= epsilon) .* (kappa * X + 16) / 116;
    fy = (Y > epsilon) .* Y .^ (1 / 3) + (Y <= epsilon) .* (kappa * Y + 16) / 116;
    fz = (Z > epsilon) .* Z .^ (1 / 3) + (Z <= epsilon) .* (kappa * Z + 16) / 116;

    L = 116 * fy - 16;
    a = 500 * (fx - fy);
    b = 200 * (fy - fz);
end
