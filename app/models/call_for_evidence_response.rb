class CallForEvidenceResponse < ApplicationRecord
  include Attachable
  include DateValidation

  belongs_to :call_for_evidence, foreign_key: :edition_id

  date_attributes(:published_on)

  validates :published_on, comparison: { greater_than: Date.parse("1900-01-01"), message: "should be greater than 1900" }
  validates :summary, presence: { unless: :has_attachments }
  validates_with SafeHtmlValidator
  validates_with NoFootnotesInGovspeakValidator, attribute: :summary
  delegate :auth_bypass_id, to: :call_for_evidence

  def access_limited_object
    call_for_evidence
  end

  delegate :access_limited?, to: :parent_attachable

  delegate :organisations, to: :parent_attachable

  delegate :alternative_format_contact_email, to: :call_for_evidence

  delegate :publicly_visible?, to: :parent_attachable

  delegate :accessible_to?, to: :parent_attachable

  delegate :unpublished?, to: :parent_attachable

  delegate :unpublished_edition, to: :parent_attachable

  def can_order_attachments?
    true
  end

  def allows_html_attachments?
    true
  end

  def path_name
    to_model.class.name.underscore
  end

  delegate :public_timestamp, :first_published_version?, :slug, :document, :images, :content_id, to: :call_for_evidence

private

  def has_attachments
    attachments.any?
  end

  def parent_attachable
    call_for_evidence || Attachable::Null.new
  end
end
