export class Content {
  id: number;
  name: string;
  description: string;
  imageUrl: string;
  enabled: boolean;
  createdDate: string;
  updateDate: string | null;;

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    imageUrl: string = '',
    enabled: boolean = false,
    createdDate: string = '',
    updateDate: string = ''
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imageUrl = imageUrl;
    this.enabled = enabled;
    this.createdDate = createdDate;
    this.updateDate = updateDate;
  }
}
