export function GetConfig(key: String): string|null {
    const element: HTMLMetaElement = document.querySelector("meta[name='" + key + "']");
    if (element === null) {
        return null;
    }
    return element.content;
}
