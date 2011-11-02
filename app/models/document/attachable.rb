module Document::Attachable
  extend ActiveSupport::Concern

  included do
    has_many :document_attachments, foreign_key: "document_id"
    has_many :attachments, through: :document_attachments
  end

  def allows_attachments?
    true
  end

  def attach_file=(file)
    self.attachments.build(file: file)
  end
end