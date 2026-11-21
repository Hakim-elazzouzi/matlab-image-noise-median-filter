% Source: https://www.mathworks.com/matlabcentral/answers/45268-noise-removal-from-colored-image
clc;	% Effacer la fenêtre de commande.
clear;	% Supprimez toutes les variables.
close all;	% Fermez toutes les fenêtres de figures sauf celles créées par imtool.
imtool close all;	% Fermez toutes les fenêtres de figures créées par imtool.
workspace;	% Assurez-vous que le panneau de l'espace de travail est affiché.
fontSize = 15;

% Lire l'image à partir du chemin (en tant qu'image réelle, pas seulement le chemin d'un fichier)
inputImage = imread('C:\Users\elazz\OneDrive\Bureau\Filtre médian\Einstein.jpg');


% Obtenez les dimensions de l'image. nombre de bandes de couleur est égal au nombre de matrices d'images 
% ou au nombre de canaux d'images (dans notre cas, j'utilise une image RVB qui donne 3).
[rows columns numberOfColorBands] = size(inputImage);

h1 = figure;
figure(h1);
% Affichez l'image originale.
subplot(2, 2, 1);
imshow(inputImage);
title('Original Image', 'FontSize', fontSize);

% Agrandir la figure en plein écran.
set(gcf, 'Position', get(0,'Screensize')); 

% Génère une image bruitée. Cela a un bruit de sel et de poivre(salt and pepper noise) indépendamment sur
% chaque canal de couleur afin que le bruit puisse être coloré.
noisyImage = imnoise(inputImage,'salt & pepper', 0.15);
subplot(2, 2, 2);
imshow(noisyImage);
title('Image with Salt and Pepper Noise', 'FontSize', fontSize);


if numberOfColorBands == 3
	%
	% C'est une image RVB(RGB)
	%
	% Extrayez les canaux de couleur rouge, vert et bleu de l'image RVB bruyante.
	redChannel = noisyImage(:, :, 1); % Red channel
	greenChannel = noisyImage(:, :, 2); % Green channel
	blueChannel = noisyImage(:, :, 3); % Blue channel

	% Normalement, les variables ci-dessus sont en niveaux de gris
	% donc nous définissons de nouvelles images juste pour afficher les canaux dans leurs couleurs correctes
	% Source: https://www.mathworks.com/matlabcentral/answers/91036-split-an-color-image-to-its-3-rgb-channels#answer_100475
	a = zeros(size(inputImage, 1), size(inputImage, 2));
	just_red = cat(3, redChannel, a, a);
	just_green = cat(3, a, greenChannel, a);
	just_blue = cat(3, a, a, blueChannel);

	% Créez une autre figure juste pour l'aperçu des 3 canaux
	h2 = figure;
	figure(h2);
	set(gcf, 'Position', get(0,'Screensize')); 
	% Affichez les canaux de couleur rouge, vert et bleu (sans bruit).
	subplot(2, 2, 1);
	imshow(just_red);
	title('Red Channel', 'FontSize', fontSize);
	subplot(2, 2, 2);
	imshow(just_green);
	title('Green Channel', 'FontSize', fontSize);
	subplot(2, 2, 3);
	imshow(just_blue);
	title('Blue Channel', 'FontSize', fontSize);

	% Filtre médian les canaux :
	redMF = medfilt2(redChannel, [7 7]);
	greenMF = medfilt2(greenChannel, [7 7]);
	blueMF = medfilt2(blueChannel, [7 7]);


	% Trouvez le bruit dans le rouge.
	noisePixels = (redChannel == 0 | redChannel == 255);
	% Débarrassez-vous du bruit dans le rouge en remplaçant par la médiane.
	noiseFreeRed1 = redChannel;
	noiseFreeRed1(noisePixels) = redMF(noisePixels);

	% Trouvez le bruit dans le vert.
	noisePixels = (greenChannel == 0 | greenChannel == 255);
	% Débarrassez-vous du bruit dans le vert en remplaçant par la médiane.
	noiseFreeGreen1 = greenChannel;
	noiseFreeGreen1(noisePixels) = greenMF(noisePixels);

	% Trouvez le bruit dans le bleu.
	noisePixels = (blueChannel == 0 | blueChannel == 255);
	% Débarrassez-vous du bruit dans le bleu en remplaçant par la médiane.
	noiseFreeBlue1 = blueChannel;
	noiseFreeBlue1(noisePixels) = blueMF(noisePixels);

	% Reconstruire l'image RVB sans bruit (médiane)
	noiseFreeImage1 = cat(3, noiseFreeRed1, noiseFreeGreen1, noiseFreeBlue1);


elseif numberOfColorBands == 1
	%
	% c'est une image en niveaux de gris
	%	
	% Médiane Filtrer l'image :
	medianFilteredImage = medfilt2(noisyImage, [7 7]);

	% Trouvez le bruit. Il aura un niveau de gris de 0 ou 255.
	noisePixels = (noisyImage == 0 | noisyImage == 255);
	
	% Débarrassez-vous du bruit en remplaçant par la médiane.
	noiseFreeImage1 = noisyImage; % Initialiser
	noiseFreeImage1(noisePixels) = medianFilteredImage(noisePixels); % Remplacer.

end

% Retour à la première figure pour afficher l'image restaurée (Filtre médian)
figure(h1);
% Affichez l'image.
subplot(2, 2, 3);
imshow(noiseFreeImage1);
title('Restored Image using Median Filter', 'FontSize', fontSize);