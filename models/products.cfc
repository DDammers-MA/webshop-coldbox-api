component table="productangular" extends="quick.models.BaseEntity" accessors="true" {
  
    property name="id";
    property name="title";
    property name="slug";
    property name="image";
    property name="image_mime"; // Corrected property name
    property name="image_size";
    property name="description";
    property name="price";
    property name="created_by";
    property name="created_at";
    property name="deleted_by";
    property name="deleted_at";
    property name="updated_by";
    property name="updated_at";
    property name="published";

  this.memento = {
        defaultIncludes : [
    "id",
    "title",
    "slug",
    "image",
    "image_mime", // Corrected property name
    "image_size",
    "description",
    "price",
    "created_by",
    "created_at",
    "deleted_by",
    "deleted_at",
    "updated_by",
    "published",
    "updated_at",
    ],
    profiles = {
      detail = {
        defaultIncludes : [

        ]
      }
      }
  }

  // Validation for create.
    this.constraints = {
        Titel = { type="string", required=true },
    };

}