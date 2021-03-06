class SIRETService
  def self.fetch(siret, dossier = nil)
    etablissement = SIADE::EtablissementAdapter.new(siret)
    entreprise = SIADE::EntrepriseAdapter.new(siren(siret))

    if etablissement.success? && entreprise.success?
      association = SIADE::RNAAdapter.new(siret)
      exercices = SIADE::ExercicesAdapter.new(siret)

      params = etablissement.to_params
        .merge(entreprise.to_params.map { |k,v| ["entreprise_#{k}", v] }.to_h)
        .merge(association.to_params&.map { |k,v| ["association_#{k}", v] }.to_h)
        .merge(exercices_attributes: exercices.to_params)

      # This is to fill legacy models and relationships
      if dossier.present?
        return params.merge(
          entreprise_attributes: entreprise.to_params
            .merge({
              dossier: dossier,
              rna_information_attributes: association.to_params
            }.compact)
        )
      else
        return params
      end
    end
  end

  def self.siren(siret)
    siret[0..8]
  end
end
