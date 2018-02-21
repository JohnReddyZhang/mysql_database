for fname in ['entity_dish.txt', 'entity_ingredients.txt',
              'relation_useingredient.txt','relation_containsallergy.txt',
              'relation_sellsingredient.txt','relation_ingredienttaste.txt',
              'entity_flavor.txt','entity_store_isle.txt','entity_store.txt',
              'relation_sellskitchenware.txt','relation_dishtaste.txt',
              'entity_kitchenware.txt','entity_kitchenware_utensil.txt',
              'entity_kitchenware_appliance.txt','entity_kitchenware_containers.txt',
              'relation_useware.txt']:
    with open(fname,'r') as fhandle:
        outhandle = open(f'{fname}_large.txt','w')
        for repeat in range(1000):
            while True:
                line = fhandle.readline()
                if not line:
                    break
                outline = '|'.join([f'{segment}' if segment.isdigit()
                                    else (f'{segment}' if segment.replace('.','').isdigit()
                                    else (f'{segment}' if ':' in segment
                                    else f'{segment}_{repeat}'))
                                    for segment in line.strip().split('|')])
                outhandle.write(f'{outline}\n')
            fhandle.seek(0)
        outhandle.close()

fname = 'entity_allergies.txt'
with open(fname,'r') as fhandle:
    outhandle = open(f'{fname}_large.txt','w')
    for repeat in range(5000):
        while True:
            line = fhandle.readline()
            if not line:
                break
            outline = '|'.join([f'{segment}' if segment == 'NULL'
                                else (f'{segment}' if segment.isdigit()
                                else (f'{segment}' if segment.replace('.','').isdigit()
                                else (f'{segment}' if ':' in segment
                                else f'{segment}_{repeat}')))
                                for segment in line.strip().split('|')])
            outhandle.write(f'{outline}\n')
        fhandle.seek(0)
    outhandle.close()
