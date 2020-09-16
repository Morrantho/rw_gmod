if !party.enabled then return; end
party.class.color = color.get("blue");
party.nettypes =
{
    string = true,
    int = true,
    float = true,
    bool = true
}