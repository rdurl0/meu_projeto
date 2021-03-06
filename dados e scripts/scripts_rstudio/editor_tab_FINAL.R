##################################################################
#'@editor_tab_FINAL                                            =
##################################################### objetivo ######
# Preparando dados brutos para análises em geral
# 
# 
#----
#----
# bibliotecas utilizadas #########################################
rm(list=ls())
library(tidyverse)
library(readr)
#----
#----
# Diretório ######################################################
setwd("C:\\Users\\rauld\\Google Drive\\meu_projeto\\dados e scripts\\planilhas_input")
dir()

# leitura
txt <- read.table("plan_FINAL.txt", h=T, stringsAsFactors = F)

# Encoding
txt$Q13       <- iconv(txt$Q13,from="UTF-8", to="latin2//TRANSLIT")
txt$Q13       <- as.character(gsub(txt$Q13, pattern="_", replacement=" "))
txt$Seccional <- iconv(txt$Seccional,from="UTF-8", to="latin2//TRANSLIT")

# tibble
txt           <- as_tibble(txt)
glimpse(txt)

# seleciona, renomeia, muda para <dbl> e mostra
txt <- txt %>%
  select(
        # Indexes
         ano          = Q1, 		  # Ano (2013) (SSP)
         distrito_num = Q12,		  # Num Distrito Policial (SSP)
         distrito     = Q13,		  # Nome Distrito Policial (SSP)
         seccional    = Seccional, # Nome da seccional
        # Crimes
         homicidio        = Q22,		# Homicídio doloso (SSP)
         homicidio_tentat = Q24,		# Tentativa de homicídio (SSP)
         lesao_corp       = Q27,		# Lesão corporal dolosa (SSP)
         latrocinio       = Q30,		# Latrocínio (SSP)
         estupro          = Q32,		# Estupro (SSP)
         trafico          = Q34,		# Ocorrências de tráfico de entorpecentes (SSP)
         porte_arma       = Q37,		# Ocorrências de porte ilegal de arma (SSP)
         roubo_veiculo    = Q40,		# Roubo de veículo (SSP)
         roubo_outros     = Q41,		# Roubo - outros (SSP)
         furto_outros     = Q43,		# Furto - outros (SSP)
         furto_veiculo    = Q44,		# Furto de veículos (SSP)
        # Vítimas
         homicidio_obito = V1,		# óitos por causas externas (por local de resid?ncia/DATASUS)
        # demografia
         populacao     = P,		    # População total (2013/IBGE-SEADE)
         pop_jovem_onu = PJ_ONU,	# População jovem ONU(15 a 24 anos)(2013/IBGE-SEADE)
         pop_jovem_cnj = PJ_CNJ,	# População jovem CNJ(15 a 29 anos)(2013/IBGE-SEADE)
         pop_masc      = PM,	   	# População masculina(2013/IBGE-SEADE)
        # Característica urbana
         favela = fvl,		# Estimativa de domicílios em favelas (2010) (SEHAB/HABISP)
        # Rendimento domiciliar
         renda_domicilio    = Tot_DR,	  # Total de domicílios particulares permanentes com rendimento (2010)(CENSO/IBGE) 
         renda_domic_ate5   = `atÃ._5`,	  # Domicílios part perm com rendimento at? 5 s.m.
         renda_domic_5a10   = X5_a_10,  # Domicílios part perm com rendimento >5 at? 10 s.m
         renda_domic_10a20  = X10_a_20,	# Domicílios part perm com rendimento >10 at? 20 s.m
         renda_domic_20mais = X20_,	  	# Domicílios part perm com rendimento >20 s.m
        # 
         renda_domic_media = RM_DOM,  # Renda domiciliar média pnderada, em s.m. 
         renda_domic_dp    = S_RM_DOM, 	# Desvio padrão RM_DOM
        # empregos
         emprego_formal = Total_EF,	# Número de empregos formais (RAIS/CAGED)
         populacao_2000 = P2000,		  # População total, ano 2010
        # produtividade policial
         inqueritos            = Q70,		# Total de in= Quéritos instaurados (SSP)		
         flagrantes            = Q71,		# Número de flagrantes lavrados (SSP)
         veiculo_recuperado    = Q73,		# Número de veículos recuperados (SSP)
         prisoes_efetuadas     = Q74,		# Número de prisães efetuadas (SSP)
         prisoes_flagrantes    = Q75,		# Número de pessoas presas em flagrante (SSP)
         prisoes_mandato       = Q76,		# Número de pessoas presas por mandato (SSP)
         infratores_flagrantes = Q77,		# Número de infratores apreendidos em flagrante (SSP)
         infratores_mandato    = Q78,		# Número de infratores apreendidos por mandato (SSP)
         armas_apreendidas     = Q79,		# Número de armas de fogo apreendidas (SSP)
        # area
         area_km2 = Km2,		# área da localidade em Km2
        # area construída em m2
         area_constr_1 = AC_1,		 # área construída 1 - uso resid?ncial horizontal de baixo padrão (TCPL/SEMPLA/SMDU)
         area_constr_2 = AC_2,  	 # área construída 2 - uso resid?ncial horizontal de médio padrão (TCPL/SEMPLA/SMDU)
         area_constr_3 = AC_3,		 # área construída 3 - uso resid?ncial horizontal de alto padrão (TCPL/SEMPLA/SMDU)
         area_constr_4 = AC_4,		 # área construída 4 - uso resid?ncial vertical de médio padrão (TCPL/SEMPLA/SMDU)
         area_constr_5 = AC_5,		 # área construída 5 - uso resid?ncial vertical de alto padrão (TCPL/SEMPLA/SMDU)
         area_constr_6 = AC_6,		 # área Construída 6 - Uso Comércio e Serviço Horizontal
         area_constr_7 = AC_7,		 # área Construída 7 - Uso Comércio e Serviço Vertical
         area_constr_8 = AC_8,		 # área Construída 8 - Uso Industrial
         area_constr_9 = AC_9,		 # área Construída 9 - Uso Armazéns e Depósitos
         area_constr_10 = AC_10,	 # área Construída 10 - Uso Especial ( Hotel, Hospital, Cartário, Etc. )
         area_constr_11 = AC_11,	 # área Construída 11 - Uso Escola
         area_constr_12 = AC_12,	 # área Construída 12 - Uso Coletivo ( Cinema, Teatro, Clube, Templo, Etc. )
         area_constr_14 = AC_14,	 # área construída 14 - uso resid?ncial vertical de baixo padrão (TCPL/SEMPLA/SMDU)
         area_constr_15 = AC_15,	 # área Construída 15 - Uso Garagens não-residenciais
         area_constr_99 = AC_99,	 # área construída 99 - outros usos (uso e padrão não previsto) (TCPL/SEMPLA/SMDU)
         area_constr_resid_baixop = AC_ResBP,# área construída - total residencial baixo padrão (=soma(AC_1;AC_14;AC_99))
         area_constr_nao_resid    = AC_nRes	 # área construída - total não residencial ((=soma(AC_6,AC_7,AC_8,AC_9,AC_10,AC_11,AC_12,AC_15)))
        ) %>%
  # use mutate_at para mudar as variáveis desejadas para <dbl>
  mutate_at(vars(-seq(4)), funs(as.numeric)) %>%
  glimpse()

write_rds(txt, "C:\\Users\\rauld\\Google Drive\\meu_projeto\\dados e scripts\\tabelas_output\\tab_FINAL.rds")








# 
#----
#----
##################################################################
#'@CONSTRUÇÃO_DE_VETORES_ADICIONAIS                              =
##################################################################
#----
#----
# Atribuindo Seccionais ##########################################

sc <- as.data.frame(
  rbind(
        c(1, "1 CENTRO"), c(2, "1 CENTRO"), c(3, "1 CENTRO"),
        c(4, "1 CENTRO"), c(5, "1 CENTRO"), c(6, "1 CENTRO"),
        c(7,"3 OESTE"), c(8, "1 CENTRO"), c(9, "4 OESTE"),
        c(10, "5 LESTE"), c(11, "6 SANTO AMARO"), c(12, "1 CENTRO"),
        c(13,"4 OESTE"), c(14, "3 OESTE"), c(15,"3 OESTE"),
        c(16, "2 SUL"), c(17, "2 SUL"), c(21, "5 LESTE"),
        c(22, "7 ITAQUERA"), c(23, "3 OESTE"), c(24, "7 ITAQUERA"),
        c(25, "6 SANTO AMARO"), c(27, "2 SUL"), c(28, "4 OESTE"),
        c(29, "5 LESTE"), c(31, "5 LESTE"), c(33, "3 OESTE"),
        c(34, "3 OESTE"), c(36, "2 SUL"), c(37, "3 OESTE"),
        c(38, "4 OESTE"), c(40, "4 OESTE"), c(41, "8 SÃO MATEUS"),
        c(42, "5 LESTE"), c(44, "8 SÃO MATEUS"), c(46, "3 OESTE"),
        c(47, "6 SANTO AMARO"), c(48, "6 SANTO AMARO"), c(50, "7 ITAQUERA"),
        c(51, "3 OESTE"), c(53, "8 SÃO MATEUS"), c(54, "8 SÃO MATEUS"),
        c(55, "8 SÃO MATEUS"), c(56, "5 LESTE"), c(58, "5 LESTE"),
        c(59, "7 ITAQUERA"), c(62, "7 ITAQUERA"),c(63, "7 ITAQUERA"),
        c(65, "7 ITAQUERA"), c(66, "8 SÃO MATEUS"), c(67, "7 ITAQUERA"),
        c(68, "7 ITAQUERA"), c(70, "8 SÃO MATEUS"), c(74, "4 OESTE"),
        c(75, "3 OESTE"), c(77, "1 CENTRO"), c(78, "1 CENTRO"),
        c(81, "5 LESTE"), c(87, "3 OESTE"), c(89, "3 OESTE"),
        c(91, "3 OESTE"), c(92, "6 SANTO AMARO"), c(93, "3 OESTE"),
        c(96, "2 SUL"), c(98, "6 SANTO AMARO"), c(99, "6 SANTO AMARO"),
        c(100, "6 SANTO AMARO"), c(102, "6 SANTO AMARO"), c(103, "7 ITAQUERA"),
        c(1857, "5 LESTE"), c(2073, "4 OESTE"), c(3052, "5 LESTE"),
        c(3264, "7 ITAQUERA"), c(3597, "2 SUL"), c(4380, "6 SANTO AMARO"),
        c(4572, "4 OESTE"), c(4969, "8 SÃO MATEUS"), c(85101, "6 SANTO AMARO"),
        c(193990, "4 OESTE"), c(268395, "2 SUL")
        ))

colnames(sc) <- c("Q12", "Seccional")

#txt <- merge(txt, sc, by = intersect("Q12", "Q12"))

#----
#----
# Adicionando vetor "distrito" (nome do distr com minúscula) #####

# na seção @EXEMPLOS_DE_COMO_TRABALHAR_COM_AS_VARIÁVEIS, criei um df 
# para trabalhar aqui

limits <- dados %>% filter(ano == 2003) %>%
  select(distrito, homic) %>% arrange(desc(homic)) %>% select(distrito)

# depois disso eu editei um arquivo .txt para usar nomes  de distritos 
# com minúsculas
txt <- read_rds("C:\\Users\\User\\Google Drive\\meu_projeto\\dados e scripts\\tabelas_output\\tab_FINAL")
limits <- read.table("C:\\Users\\User\\Desktop\\limits.txt", h=T, stringsAsFactors = F)
limits$Q13 <- limits$distrito2
limits$distrito2 <- NULL
txt <- merge(txt, limits, by = intersect("Q13", "Q13"))
write_rds(txt, "C:\\Users\\User\\Google Drive\\meu_projeto\\dados e scripts\\tabelas_output\\tab_FINAL")
#----
#----
##################################################################
#'@EXEMPLOS_DE_COMO_TRABALHAR_COM_AS_VARIÁVEIS                   =
##################################################################
#----
#----
# indexes ########################################################
Ano      <- txt$Q1
Distrito <- txt$Q13
Dpol     <- txt$Q12

# Y
txt$homic    <- (txt$Q22/txt$P)*100000
txt$roubovlc <- (txt$Q40/txt$P)*100000
txt$furtovlc <- (txt$Q43/txt$P)*100000

# X
txt$jov1524      <- (txt$PMJ_ONU/txt$P)
txt$baixopadrao  <- (txt$AC_ResBP/1000)
txt$rendamedia   <- txt$RM_DOM
txt$dprendamedia <- txt$S_RM_DOM
txt$favela       <- (txt$fvl/txt$P)*100000
txt$eformais     <- txt$EF_P
txt$mandato      <- (txt$Q76/txt$P)*100000

# outras
txt$prisoes   <- (txt$Q74/txt$P)*100000
txt$flagrante <- (txt$Q75/txt$P)*100000
txt$DENS      <- (txt$P/txt$Km2)
#----
#----
# data.frame ############################################
dados <- data.frame(Ano          = as.integer(Ano),
                    Distrito     = as.factor(Distrito),
                    Dpol         = as.integer(Dpol),
                    Seccional    = as.factor(txt$Seccional),
                    homic        = as.numeric(txt$homic),
                    roubovcl     = as.numeric(txt$roubovlc),
                    furtovcl     = as.numeric(txt$furtovlc),
                    jov1524      = as.numeric(txt$jov1524),
                    baixopadrao  = as.numeric(txt$baixopadrao),
                    rendamedia   = as.numeric(txt$rendamedia),
                    dprendamedia = as.numeric(txt$dprendamedia),
                    favela       = as.numeric(txt$favela),
                    eformais     = as.numeric(txt$eformais),
                    mandato      = as.numeric(txt$mandato),
                    stringsAsFactors = FALSE)
#----
#----
# data.frame ############################################
crimes <- c("Homicídio (Q22)",
            "Tentat Homicídio (Q24)",
            "Lesão Corporal dol.(Q27)",
            "Latrocínio (Q30)",
            "Estupro (Q32)",
            "tráfico (Q34)",
            "Porte de arma (Q37)",
            "Roubo - veículos (Q40)",
            "Roubo - outros (Q41)",
            "Furto - veículos (Q44)",
            "Furto - outros (Q44)",
            "óitos por agressão (V1)")
