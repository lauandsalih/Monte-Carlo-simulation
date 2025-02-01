clear all; 
figure;

for k = 1:6
    
    for i = 1:10 
        t = 0;  
        a = 0; 
        aika = [];  
        jono = [];  
        
        while t < 8*60 
            seuraava_asiakas_saapuu = exprnd(3); % Generoi seuraavan asiakkaan saapumisen ajan
            kassoja_kaytossa = min(a,k); % Määrittää käytössä olevien kassojen määrä (vähintään 0 ja enintään k)
            if kassoja_kaytossa > 0
                palvelut_valmistuu = min(exprnd(5,kassoja_kaytossa,1)); % Generoi kassojen palvelun valmistumisen ajan ja valitsee pienimmän
            else
                palvelut_valmistuu = Inf; % kikka
            end

            % Jos asiakas saapuu ennen kuin palvelut valmistuvat, a:n määrä kasvaa. Muutoin se pienenee
            if seuraava_asiakas_saapuu < palvelut_valmistuu
                a = a+1; % Asiakkaiden määrä kasvaa yhdellä
                t = t + seuraava_asiakas_saapuu; % Aikaan lisätään seuraavan asiakkaan saapumisen aika
            else
                a = a - 1; % Asiakkaiden määrä pienenee yhdellä
                t = t + palvelut_valmistuu; % Aikaan lisätään palvelun valmistumisen aika
            end

            jono(end+1) = max(0,a-k); % Lisätään jonoon asiakkaiden määrä, jotka eivät ole kassalla
            aika(end+1) = t;
        end

        % Piirretään kuvaaja eri värillä
        subplot(3,2,k);
        hold on;
        stairs(jono); 
        grid on; 
        title(num2str(k),'kassaa');
        xlabel('Aika (min)');
        ylabel('Jonon pituus (n)'); 
    end
end
