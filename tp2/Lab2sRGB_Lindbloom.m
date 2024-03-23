function Image = Lab2sRGB_Lindbloom(L, a, b)
    % Paramètres constants pour la conversion
    epsilon = 0.008856;
    kappa = 903.3;
    
    % Valeurs de référence pour l'illuminant D65
    X1 = 0.9504;
    Y1 = 1;
    Z1 = 1.0888;

    % Transformation des valeurs Lab en valeurs XYZ
    fynew = (L + 16) / 116;
    fxnew = fynew + a / 500;
    fznew = fynew - b / 200;

    Xnew = (fxnew .^ 3 > epsilon) .* fxnew .^ 3 + (fxnew .^ 3 <= epsilon) .* (116 * fxnew - 16) / kappa;
    Ynew = (L > kappa * epsilon) .* ((L + 16) / 116) .^ 3 + (L <= kappa * epsilon) .* (L / kappa);
    Znew = (fznew .^ 3 > epsilon) .* fznew .^ 3 + (fznew .^ 3 <= epsilon) .* (116 * fznew - 16) / kappa;

    Xnew = Xnew * X1;
    Ynew = Ynew * Y1;
    Znew = Znew * Z1;

    % Transformation de l'espace colorimétrique XYZ en espace colorimétrique RGB linéaire (Lindbloom)
    RGB_new(:, :, 1) = Xnew(:, :) * 3.2404542 + Ynew(:, :) * (-1.5371385) + Znew(:, :) * (-0.4985314);
    RGB_new(:, :, 2) = Xnew(:, :) * (-0.9692660) + Ynew(:, :) * 1.8760108 + Znew(:, :) * 0.0415560;
    RGB_new(:, :, 3) = Xnew(:, :) * 0.0556434 + Ynew(:, :) * (-0.2040259) + Znew(:, :) * 1.0572252;

    % Transformation de l'espace colorimétrique RGB linéaire en espace colorimétrique sRGB
    RGB_new = (RGB_new <= 0.0031308) .* (12.92 * RGB_new) + (RGB_new > 0.0031308) .* (1.055 * RGB_new .^ (1 / 2.4) - 0.055);

    % Mise à l'échelle des valeurs RGB dans la plage [0, 255] et conversion en type uint8
    Z = (255 * RGB_new);
    Image = uint8(Z);
end
